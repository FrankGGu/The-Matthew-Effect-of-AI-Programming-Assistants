int subarraysWithKDistinct(int* A, int ASize, int K) {
    int count(int* A, int ASize, int K) {
        int freq[100001] = {0}, res = 0, left = 0, right = 0, uniqueCount = 0;
        while (right < ASize) {
            if (freq[A[right]]++ == 0) uniqueCount++;
            while (uniqueCount > K) {
                if (--freq[A[left]] == 0) uniqueCount--;
                left++;
            }
            res += right - left + 1;
            right++;
        }
        return res;
    }
    return count(A, ASize, K) - count(A, ASize, K - 1);
}