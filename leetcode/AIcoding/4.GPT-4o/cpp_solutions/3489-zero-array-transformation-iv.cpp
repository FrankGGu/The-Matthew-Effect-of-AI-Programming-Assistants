class Solution {
public:
    bool canTransform(vector<int>& arr) {
        int n = arr.size();
        vector<int> count(1001, 0);

        for (int num : arr) {
            count[num]++;
        }

        for (int i = 0; i < n; i++) {
            if (arr[i] != 0) {
                int x = arr[i];
                if (count[x] == 0) return false;
                count[x]--;
                if (count[x] == 0) {
                    arr[i] = 0;
                }
            }
        }

        return true;
    }
};