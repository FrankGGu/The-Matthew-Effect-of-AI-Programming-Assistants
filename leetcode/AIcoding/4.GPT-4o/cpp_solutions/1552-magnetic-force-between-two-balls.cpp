class Solution {
public:
    int maxDistance(vector<int>& position, int m) {
        sort(position.begin(), position.end());
        int left = 1, right = position.back() - position.front(), result = 0;

        while (left <= right) {
            int mid = left + (right - left) / 2;
            if (canPlace(position, mid, m)) {
                result = mid;
                left = mid + 1;
            } else {
                right = mid - 1;
            }
        }
        return result;
    }

    bool canPlace(vector<int>& position, int distance, int m) {
        int count = 1, lastPosition = position[0];
        for (int i = 1; i < position.size(); i++) {
            if (position[i] - lastPosition >= distance) {
                count++;
                lastPosition = position[i];
                if (count == m) return true;
            }
        }
        return count >= m;
    }
};