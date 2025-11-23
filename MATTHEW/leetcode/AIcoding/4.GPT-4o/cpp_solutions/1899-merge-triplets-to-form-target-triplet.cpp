class Solution {
public:
    bool mergeTriplets(vector<vector<int>>& triplets, vector<int>& target) {
        int max1 = 0, max2 = 0, max3 = 0;
        for (const auto& triplet : triplets) {
            if (triplet[0] > target[0] || triplet[1] > target[1] || triplet[2] > target[2]) continue;
            max1 = max(max1, triplet[0]);
            max2 = max(max2, triplet[1]);
            max3 = max(max3, triplet[2]);
        }
        return max1 == target[0] && max2 == target[1] && max3 == target[2];
    }
};