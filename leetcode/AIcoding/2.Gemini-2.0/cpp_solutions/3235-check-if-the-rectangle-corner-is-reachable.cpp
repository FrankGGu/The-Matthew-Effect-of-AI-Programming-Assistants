class Solution {
public:
    bool isRectangleCover(int sx, int sy, int ex, int ey, vector<vector<int>>& rectangles) {
        long long area = 0;
        unordered_map<long long, int> cnt;
        for (auto& rect : rectangles) {
            int x1 = rect[0], y1 = rect[1], x2 = rect[2], y2 = rect[3];
            area += (long long)(x2 - x1) * (y2 - y1);

            long long p1 = ((long long)x1 << 32) | y1;
            long long p2 = ((long long)x1 << 32) | y2;
            long long p3 = ((long long)x2 << 32) | y1;
            long long p4 = ((long long)x2 << 32) | y2;

            cnt[p1]++;
            cnt[p2]++;
            cnt[p3]++;
            cnt[p4]++;
        }

        int corners = 0;
        for (auto& [point, count] : cnt) {
            if (count % 2 != 0) {
                corners++;
            }
        }

        if (corners != 4) {
            return false;
        }

        long long s = ((long long)sx << 32) | sy;
        long long e = ((long long)ex << 32) | ey;
        long long s1 = ((long long)sx << 32) | ey;
        long long e1 = ((long long)ex << 32) | sy;

        if (cnt.find(s) == cnt.end() || cnt.find(e) == cnt.end() || cnt.find(s1) == cnt.end() || cnt.find(e1) == cnt.end() ) return false;

        long long expectedArea = (long long)(ex - sx) * (ey - sy);
        return area == expectedArea;
    }
};