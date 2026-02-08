class Solution {
public:
    vector<double> sampleStats(vector<int>& count) {
        double minVal = INT_MAX, maxVal = INT_MIN, sum = 0;
        int total = 0, mode = 0, maxCount = 0;

        for (int i = 0; i < 256; ++i) {
            if (count[i] > 0) {
                if (minVal == INT_MAX) minVal = i;
                maxVal = i;
                sum += i * count[i];
                total += count[i];
                if (count[i] > maxCount) {
                    maxCount = count[i];
                    mode = i;
                }
            }
        }

        double mean = sum / total;
        double median = 0;

        int half = total / 2;
        int countSoFar = 0;
        for (int i = 0; i < 256; ++i) {
            countSoFar += count[i];
            if (countSoFar >= half) {
                if (total % 2 == 0 && countSoFar == half) {
                    for (int j = i + 1; j < 256; ++j) {
                        if (count[j] > 0) {
                            median = (i + j) / 2.0;
                            break;
                        }
                    }
                } else {
                    median = i;
                }
                break;
            }
        }

        return {minVal, maxVal, mean, median, mode};
    }
};