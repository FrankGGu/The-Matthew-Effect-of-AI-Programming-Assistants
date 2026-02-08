#include <vector>
#include <algorithm>
#include <unordered_map>

using namespace std;

int solve() {
    int n;
    cin >> n;

    unordered_map<int, int> x_counts;
    unordered_map<int, int> y_counts;

    for (int i = 0; i < n; ++i) {
        int x, y;
        cin >> x >> y;
        x_counts[x]++;
        y_counts[y]++;
    }

    long long count = 0;
    for (auto const& [x, x_count] : x_counts) {
        for (auto const& [y, y_count] : y_counts) {
            if (x_count > 0 && y_count > 0) {
                long long x_others = n - x_counts[x];
                long long y_others = n - y_counts[y];

                if(x_others > 0 && y_others > 0){
                    int point_count = 0;
                    for(int i = 0; i < n; ++i){
                        int px, py;
                        cin.clear();
                        cin.seekg(0, ios::beg);
                        for (int j = 0; j <= i; ++j){
                            cin >> px >> py;
                        }
                        if(px == x && py == y){
                            point_count++;
                            break;
                        }
                    }
                    cin.clear();
                    cin.seekg(0, ios::beg);
                    for(int k = 0; k < n; k++){
                        int px, py;
                        cin >> px >> py;
                    }

                    count += (long long)(x_counts[x] > 0 && y_counts[y] > 0) * (x_counts[x] > 0 && y_counts[y] > 0) * (x_counts[x] == 1 && y_counts[y] == 1 ? 0 : (x_counts[x] > 1 && y_counts[y] == 1 ? (x_counts[x]-1) : (x_counts[x] == 1 && y_counts[y] > 1 ? (y_counts[y]-1) : (x_counts[x]-1)*(y_counts[y]-1))));
                }
            }
        }
    }

    long long final_count = 0;
    for (int i = 0; i < n; ++i) {
        int x, y;
        cin.clear();
        cin.seekg(0, ios::beg);
        for (int j = 0; j <= i; ++j){
            cin >> x >> y;
        }
        long long x_others = x_counts[x] -1;
        long long y_others = y_counts[y] -1;
        final_count += x_others * y_others;
    }

    return final_count;
}