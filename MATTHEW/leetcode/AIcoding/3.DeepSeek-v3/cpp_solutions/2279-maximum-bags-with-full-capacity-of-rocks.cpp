class Solution {
public:
    int maximumBags(vector<int>& capacity, vector<int>& rocks, int additionalRocks) {
        vector<int> diff;
        for (int i = 0; i < capacity.size(); ++i) {
            diff.push_back(capacity[i] - rocks[i]);
        }
        sort(diff.begin(), diff.end());
        int count = 0;
        for (int d : diff) {
            if (additionalRocks >= d) {
                additionalRocks -= d;
                count++;
            } else {
                break;
            }
        }
        return count;
    }
};