#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int maxTotalFruits(vector<vector<int>>& fruits, int startPos, int k) {
        int n = fruits.size();
        int left = 0, right = n - 1;
        while (left < right) {
            int mid = (left + right) / 2;
            if (fruits[mid][0] < startPos) {
                left = mid + 1;
            } else {
                right = mid;
            }
        }

        int ans = 0;
        for (int i = left; i < n; ++i) {
            for (int j = left - 1; j >= 0; --j) {
                int dist = abs(fruits[i][0] - startPos) + abs(fruits[j][0] - startPos) + min(abs(fruits[i][0] - startPos), abs(fruits[j][0] - startPos));

                if (dist <= k) {
                    int sum = 0;
                    for (int l = j; l <= i; ++l) {
                        sum += fruits[l][1];
                    }
                    ans = max(ans, sum);
                }
            }
        }

        for (int i = left -1; i >= 0; --i) {
            for (int j = left; j < n; ++j) {
                int dist = abs(fruits[i][0] - startPos) + abs(fruits[j][0] - startPos) + min(abs(fruits[i][0] - startPos), abs(fruits[j][0] - startPos));

                if (dist <= k) {
                    int sum = 0;
                    for (int l = i; l <= j; ++l) {
                        sum += fruits[l][1];
                    }
                    ans = max(ans, sum);
                }
            }
        }

        int sum = 0;
        for(int i = 0; i < n; ++i) {
          if(abs(fruits[i][0] - startPos) <= k) {
            sum += fruits[i][1];
          }
        }

        int sum2 = 0;
        int l = left;
        int r = left;

        while(l >= 0 && abs(fruits[l][0] - startPos) > k) {
            l--;
        }

        while(r < n && abs(fruits[r][0] - startPos) > k) {
            r++;
        }

        if(l >= 0 && r < n) {
            sum2 = 0;
            int l2 = l;
            int r2 = r;
            while(l2 >= 0 && r2 < n) {
                int dist = abs(fruits[l2][0] - startPos) + abs(fruits[r2][0] - startPos) + min(abs(fruits[l2][0] - startPos), abs(fruits[r2][0] - startPos));
                if(dist <= k) {
                    int tempSum = 0;
                    for(int i = l2; i <= r2; ++i) {
                        tempSum += fruits[i][1];
                    }
                    sum2 = max(sum2, tempSum);
                }

                if(abs(fruits[l2-1][0] - startPos) <= k) {
                    l2--;
                } else if(abs(fruits[r2 + 1][0] - startPos) <= k) {
                    r2++;
                } else {
                    break;
                }
            }
        }

        int initialSum = 0;
        l = left;
        r = left - 1;
        while(l < n && abs(fruits[l][0] - startPos) <= k) {
            initialSum += fruits[l][1];
            l++;
        }
        ans = max(ans, initialSum);

        initialSum = 0;
        l = left;
        r = left - 1;
        while(r >= 0 && abs(fruits[r][0] - startPos) <= k) {
            initialSum += fruits[r][1];
            r--;
        }
        ans = max(ans, initialSum);

        int start_index = -1;
        for(int i = 0; i < n; ++i) {
            if(fruits[i][0] == startPos) {
                start_index = i;
                break;
            }
        }

        if(start_index != -1 && k >= 0) {
            int sum_start = 0;
            for(int i = 0; i < n; ++i) {
                int dist = abs(fruits[i][0] - startPos);
                if(dist <= k) {
                    sum_start += fruits[i][1];
                }
            }
            ans = max(ans, sum_start);
        }

        int sum_direct = 0;
        for(int i = 0; i < n; ++i) {
            if(abs(fruits[i][0] - startPos) <= k && fruits[i][0] == startPos) {
                sum_direct = fruits[i][1];
                break;
            }
        }

        if(n > 0) {
          int sum_left = 0;
          int sum_right = 0;

          int left_most = -1;
          int right_most = -1;

          for(int i = 0; i < n; ++i) {
              if(fruits[i][0] <= startPos && abs(fruits[i][0] - startPos) <= k) {
                  left_most = i;
              }
              if(fruits[i][0] >= startPos && abs(fruits[i][0] - startPos) <= k) {
                  right_most = i;
              }
          }

            if (left_most != -1 && right_most != -1) {
                for (int i = left_most; i <= right_most; ++i) {
                    sum_right += fruits[i][1];
                }
                ans = max(ans, sum_right);
            }
        }

        return ans;
    }
};