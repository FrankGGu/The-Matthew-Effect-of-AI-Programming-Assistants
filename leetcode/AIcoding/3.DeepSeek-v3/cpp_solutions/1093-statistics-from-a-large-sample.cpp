class Solution {
public:
    vector<double> sampleStats(vector<int>& count) {
        vector<double> res(5, 0.0);
        int total = 0;
        double sum = 0.0;
        int max_count = 0;
        int mode = 0;

        for (int i = 0; i < 256; ++i) {
            if (count[i] > 0) {
                if (res[0] == 0.0) res[0] = i;
                res[1] = i;
                sum += i * count[i];
                total += count[i];
                if (count[i] > max_count) {
                    max_count = count[i];
                    mode = i;
                }
            }
        }
        res[2] = sum / total;
        res[4] = mode;

        int median_pos1 = (total + 1) / 2;
        int median_pos2 = (total + 2) / 2;
        int cnt = 0;
        double median = 0.0;
        for (int i = 0; i < 256; ++i) {
            if (cnt < median_pos1 && cnt + count[i] >= median_pos1) {
                median += i;
            }
            if (cnt < median_pos2 && cnt + count[i] >= median_pos2) {
                median += i;
                break;
            }
            cnt += count[i];
        }
        res[3] = median / 2.0;

        return res;
    }
};