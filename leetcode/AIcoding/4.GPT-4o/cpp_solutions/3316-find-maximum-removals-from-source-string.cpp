class Solution {
public:
    bool canRemove(string &s, string &p, int k) {
        string temp = s;
        for (int i = 0; i < k; i++) {
            temp.erase(remove(temp.begin(), temp.end(), s[i]), temp.end());
        }
        int j = 0;
        for (char c : temp) {
            if (j < p.size() && c == p[j]) j++;
        }
        return j == p.size();
    }

    int maximumRemovals(string s, string p, vector<int>& removable) {
        int left = 0, right = removable.size(), answer = 0;

        while (left <= right) {
            int mid = left + (right - left) / 2;
            if (canRemove(s, p, mid)) {
                answer = mid;
                left = mid + 1;
            } else {
                right = mid - 1;
            }
        }

        return answer;
    }
};