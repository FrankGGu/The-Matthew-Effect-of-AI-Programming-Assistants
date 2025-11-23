import collections
import heapq

class Solution:
    def mostFrequentIDs(self, ids: list[int], freqs: list[int]) -> list[int]:
        id_counts = collections.defaultdict(int)
        max_heap = [] # Stores (-frequency, id)
        result = []

        for i in range(len(ids)):
            current_id = ids[i]
            change_freq = freqs[i]

            id_counts[current_id] += change_freq

            # Push the new frequency onto the heap
            heapq.heappush(max_heap, (-id_counts[current_id], current_id))

            # Clean up stale entries at the top of the heap
            while max_heap:
                neg_freq, _id = max_heap[0]
                if id_counts[_id] == -neg_freq:
                    # This is a valid, current maximum frequency
                    break
                else:
                    # This entry is stale, pop it
                    heapq.heappop(max_heap)

            # After cleanup, the top of the heap (if not empty) holds the current max frequency
            if max_heap:
                result.append(-max_heap[0][0])
            else:
                result.append(0)

        return result