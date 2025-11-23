#include <iostream>
#include <vector>
#include <climits>

using namespace std;

class Solution {
public:
    vector<int> closestEqual(vector<int>& arr, vector<vector<int>>& queries) {
        int n = arr.size();
        int m = queries.size();
        vector<int> result(m);

        for (int i = 0; i < m; ++i) {
            int index1 = queries[i][0];
            int index2 = queries[i][1];
            int min_dist = INT_MAX;

            for (int j = 0; j < n; ++j) {
                if (arr[j] == arr[index1]) {
                    min_dist = min(min_dist, abs(j - index1));
                }
            }

            if (min_dist == INT_MAX) {
                result[i] = -1;
            } else {
                result[i] = min_dist;
            }

             min_dist = INT_MAX;
              for (int j = 0; j < n; ++j) {
                if (arr[j] == arr[index2]) {
                    min_dist = min(min_dist, abs(j - index2));
                }
            }

            if (min_dist == INT_MAX) {
                result[i] = -1;
            } else {

            }
              int final_dist = INT_MAX;

              for(int j = 0; j < n; j++){
                  if(arr[j] == arr[index1] && arr[j] == arr[index2]){
                      final_dist = min(final_dist, min(abs(j - index1), abs(j - index2)));

                  }
              }

              int dist1 = INT_MAX;
              for(int j = 0; j < n; j++){
                  if(arr[j] == arr[index1]){
                      dist1 = min(dist1, abs(j - index1));
                  }
              }

              int dist2 = INT_MAX;
               for(int j = 0; j < n; j++){
                  if(arr[j] == arr[index2]){
                      dist2 = min(dist2, abs(j - index2));
                  }
              }

              if(dist1 == INT_MAX || dist2 == INT_MAX){
                  result[i] = -1;
              }
              else{
                   min_dist = min(dist1, dist2);
                   if(min_dist == INT_MAX){
                      result[i] = -1;
                   }
                   else
                   {
                      result[i] = min_dist;
                   }
              }
        }

        return result;
    }
};