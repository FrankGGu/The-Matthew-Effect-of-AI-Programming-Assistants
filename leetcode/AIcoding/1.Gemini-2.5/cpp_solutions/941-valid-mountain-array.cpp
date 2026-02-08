class Solution {
public:
    bool validMountainArray(std::vector<int>& arr) {
        int n = arr.size();
        if (n < 3) {
            return false;
        }

        int i = 0;
        // Walk up the mountain
        while (i + 1 < n && arr[i] < arr[i+1]) {
            i++;
        }

        // Peak cannot be the first or last element
        if (i == 0 || i == n - 1) {
            return false;
        }

        // Walk down the mountain
        while (i + 1 < n && arr[i] > arr[i+1]) {
            i++;
        }

        // If we reached the end, it's a valid mountain
        return i == n - 1;
    }
};