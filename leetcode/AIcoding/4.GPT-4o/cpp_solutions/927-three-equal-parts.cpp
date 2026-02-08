class Solution {
public:
    vector<int> threeEqualParts(vector<int>& arr) {
        int totalOnes = count(arr.begin(), arr.end(), 1);
        if (totalOnes % 3 != 0) return {-1, -1};
        if (totalOnes == 0) return {0, 2};

        int onesCount = totalOnes / 3;
        int first = -1, second = -1, third = -1;
        int currentOnes = 0;

        for (int i = 0; i < arr.size(); i++) {
            if (arr[i] == 1) {
                currentOnes++;
                if (currentOnes == 1) first = i;
                else if (currentOnes == onesCount + 1) second = i;
                else if (currentOnes == 2 * onesCount + 1) third = i;
            }
        }

        while (third < arr.size() && arr[first] == arr[second] && arr[second] == arr[third]) {
            first++;
            second++;
            third++;
        }

        return (third == arr.size()) ? vector<int>{first - 1, second} : vector<int>{-1, -1};
    }
};