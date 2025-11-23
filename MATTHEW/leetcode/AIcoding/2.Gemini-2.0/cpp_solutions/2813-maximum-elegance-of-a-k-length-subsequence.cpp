#include <vector>
#include <algorithm>

using namespace std;

long long maxElegance(vector<vector<int>>& items, int k) {
    sort(items.begin(), items.end(), [](const auto& a, const auto& b) {
        return a[0] > b[0];
    });

    long long profit = 0;
    vector<int> categories;
    long long elegance = 0;
    int categoryCount = 0;

    for (int i = 0; i < k; ++i) {
        profit += items[i][0];
        categories.push_back(items[i][1]);
    }

    vector<int> counts(100001, 0);
    for (int category : categories) {
        counts[category]++;
        if (counts[category] == 1) {
            categoryCount++;
        }
    }

    elegance = profit + (long long)categoryCount * categoryCount;

    for (int i = k; i < items.size(); ++i) {
        int j = k - 1;
        while (j >= 0 && items[i][0] > items[j][0]) {
            j--;
        }
        j++;

        if (j < k) {
            int removedCategory = categories[k - 1];

            vector<int> tempCounts = counts;

            tempCounts[removedCategory]--;
            int tempCategoryCount = categoryCount;
            if(tempCounts[removedCategory] == 0){
                tempCategoryCount--;
            }

            tempCounts[items[i][1]]++;
            if(tempCounts[items[i][1]] == 1){
                tempCategoryCount++;
            }

            if (items[i][0] - items[k - 1][0] > 0) {
                long long newProfit = profit - items[k - 1][0] + items[i][0];
                long long newElegance = newProfit + (long long)tempCategoryCount * tempCategoryCount;

                if (newElegance > elegance) {

                    profit = newProfit;

                    counts = tempCounts;
                    categoryCount = tempCategoryCount;
                    categories[k-1] = items[i][1];

                    elegance = newElegance;

                    sort(categories.begin(), categories.end());
                }
            }
        }
    }

    return elegance;
}