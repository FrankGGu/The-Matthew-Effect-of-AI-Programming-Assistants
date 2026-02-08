#include <vector>
#include <algorithm> // Required for std::sort and std::max
#include <functional> // Required for std::greater

class Solution {
public:
    long long minProcessingTime(std::vector<int>& processorTime, std::vector<int>& tasks) {
        // Sort processorTime in ascending order.
        // This ensures that processors that become available earliest are considered first.
        std::sort(processorTime.begin(), processorTime.end());

        // Sort tasks in descending order.
        // This greedy strategy pairs the earliest available processors with the longest tasks.
        // By assigning the longest tasks to the processors that become available earliest,
        // we aim to minimize the overall maximum completion time.
        std::sort(tasks.begin(), tasks.end(), std::greater<int>());

        long long minOverallProcessingTime = 0;
        int numProcessors = processorTime.size();

        // Iterate through each processor.
        // Each processor is assigned 4 tasks.
        // The i-th processor (after sorting processorTime) will be assigned tasks
        // starting from index 4*i in the sorted (descending) tasks array.
        // Since tasks are sorted descending, tasks[4*i] will be the longest among
        // the four tasks assigned to the current processor.
        for (int i = 0; i < numProcessors; ++i) {
            // Calculate the completion time for the current processor.
            // This is the processor's availability time plus the duration of the longest task it processes.
            long long currentProcessorCompletionTime = (long long)processorTime[i] + tasks[4 * i];

            // The overall minimum processing time is the maximum of all individual processor completion times.
            minOverallProcessingTime = std::max(minOverallProcessingTime, currentProcessorCompletionTime);
        }

        return minOverallProcessingTime;
    }
};