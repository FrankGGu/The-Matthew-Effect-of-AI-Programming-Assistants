class Solution {
public:
    long long kthSmallestProduct(vector<int>& nums1, vector<int>& nums2, long long k) {
        vector<long long> A, B, negA, negB, posA, posB;
        for (int num : nums1) {
            if (num < 0) negA.push_back(-num);
            else posA.push_back(num);
        }
        for (int num : nums2) {
            if (num < 0) negB.push_back(-num);
            else posB.push_back(num);
        }
        reverse(negA.begin(), negA.end());
        reverse(negB.begin(), negB.end());

        long long left = -1e10, right = 1e10;
        while (left < right) {
            long long mid = left + (right - left) / 2;
            long long cnt = countLessOrEqual(negA, posB, mid) + countLessOrEqual(posA, negB, mid) + countLessOrEqual(negA, negB, -mid - 1) + countLessOrEqual(posA, posB, mid);
            if (cnt < k) {
                left = mid + 1;
            } else {
                right = mid;
            }
        }
        return left;
    }

    long long countLessOrEqual(vector<long long>& A, vector<long long>& B, long long target) {
        long long res = 0;
        int j = B.size() - 1;
        for (int i = 0; i < A.size(); ++i) {
            while (j >= 0 && A[i] * B[j] > target) {
                --j;
            }
            res += j + 1;
        }
        return res;
    }
};