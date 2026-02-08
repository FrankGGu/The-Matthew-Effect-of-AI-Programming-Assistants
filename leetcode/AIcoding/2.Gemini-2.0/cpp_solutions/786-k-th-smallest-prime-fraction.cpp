#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    vector<int> kthSmallestPrimeFraction(vector<int>& arr, int k) {
        int n = arr.size();
        double low = 0.0, high = 1.0;

        while (low < high) {
            double mid = low + (high - low) / 2.0;
            int count = 0;
            int j = n - 1;

            for (int i = 0; i < n - 1; ++i) {
                while (j > i && (double)arr[i] / arr[j] > mid) {
                    --j;
                }
                count += (n - 1 - j);
            }

            if (count < k) {
                low = mid;
            } else {
                high = mid;
            }
        }

        double target = low;
        int p = 0, q = 1;
        for (int i = 0; i < n; ++i) {
            for (int j = i + 1; j < n; ++j) {
                double fraction = (double)arr[i] / arr[j];
                if (abs(fraction - target) < 1e-9) {
                    int count = 0;
                    int jj = n - 1;

                    for (int ii = 0; ii < n - 1; ++ii) {
                        while (jj > ii && (double)arr[ii] / arr[jj] > fraction) {
                            --jj;
                        }
                        count += (n - 1 - jj);
                    }

                    if (count == k-1)
                        return {arr[i], arr[j]};
                }
                if ((double)arr[i] / arr[j] < target) {
                    if ((double)arr[i] / arr[j] > (double)p / q) {
                        p = arr[i];
                        q = arr[j];
                    }
                }
            }
        }

        int i_ans = 0;
        int j_ans = 0;
        double min_diff = 1e9;

        for(int i=0; i<n; i++){
            for(int j=i+1; j<n; j++){
                double diff = abs((double)arr[i]/arr[j] - target);
                if(diff < min_diff){
                    min_diff = diff;
                    i_ans = i;
                    j_ans = j;
                }
            }
        }

        return {arr[i_ans], arr[j_ans]};
    }
};