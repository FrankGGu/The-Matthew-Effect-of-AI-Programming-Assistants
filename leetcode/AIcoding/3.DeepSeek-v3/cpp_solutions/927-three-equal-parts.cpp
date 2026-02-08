class Solution {
public:
    vector<int> threeEqualParts(vector<int>& arr) {
        int count = 0;
        for (int num : arr) {
            if (num == 1) {
                count++;
            }
        }

        if (count == 0) {
            return {0, 2};
        }

        if (count % 3 != 0) {
            return {-1, -1};
        }

        int k = count / 3;
        int i = find(arr, 1);
        int j = find(arr, k + 1);
        int l = find(arr, 2 * k + 1);

        while (l < arr.size() && arr[i] == arr[j] && arr[j] == arr[l]) {
            i++;
            j++;
            l++;
        }

        if (l == arr.size()) {
            return {i - 1, j};
        } else {
            return {-1, -1};
        }
    }

private:
    int find(vector<int>& arr, int cnt) {
        int res = 0;
        for (; res < arr.size(); res++) {
            if (arr[res] == 1) {
                cnt--;
                if (cnt == 0) {
                    break;
                }
            }
        }
        return res;
    }
};