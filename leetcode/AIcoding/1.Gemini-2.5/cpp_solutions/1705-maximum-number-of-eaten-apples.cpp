#include <vector>
#include <queue>
#include <utility> // For std::pair

class Solution {
public:
    int eatenApples(std::vector<int>& apples, std::vector<int>& days) {
        int eaten_apples = 0;
        int n = apples.size();

        // Min-priority queue to store pairs of (decay_day, count)
        // decay_day: the day on which the apples will rot
        // count: number of apples that will rot on that day
        std::priority_queue<std::pair<int, int>, 
                            std::vector<std::pair<int, int>>, 
                            std::greater<std::pair<int, int>>> pq;

        int i = 0;
        // Loop continues as long as there are new apples to consider (i < n)
        // or there are still edible apples in the priority queue.
        while (i < n || !pq.empty()) {
            // 1. Add new apples grown on day 'i'
            if (i < n && apples[i] > 0) {
                // An apple grown on day 'i' with shelf life 'days[i]' will rot on day 'i + days[i]'
                pq.push({i + days[i], apples[i]});
            }

            // 2. Remove rotten apples from the priority queue
            // Apples whose decay_day is less than or equal to the current day 'i' are rotten.
            while (!pq.empty() && pq.top().first <= i) {
                pq.pop();
            }

            // 3. Eat an apple if available
            if (!pq.empty()) {
                // Get the apple batch that rots soonest
                std::pair<int, int> current_batch = pq.top();
                pq.pop();

                eaten_apples++; // Eat one apple
                current_batch.second--; // Decrement count

                // If there are still apples left in this batch, push it back
                if (current_batch.second > 0) {
                    pq.push(current_batch);
                }
            }

            i++; // Move to the next day
        }

        return eaten_apples;
    }
};