import heapq

class Solution:
    def kthSmallestSum(self, mat: list[list[int]], k: int) -> int:

        # Helper function to merge two sorted lists of sums and find the k smallest sums
        def merge_k_smallest_sums(list1, list2, k_val):
            m = len(list1)
            n = len(list2)

            # If any list is empty, there are no sums to form
            if m == 0 or n == 0:
                return []

            # Min-heap to store (sum, index_in_list1, index_in_list2)
            min_heap = []

            # Use a set to keep track of visited (i, j) pairs to avoid adding duplicate sums to the heap
            visited = set()

            # Start with the sum of the first elements from both lists
            heapq.heappush(min_heap, (list1[0] + list2[0], 0, 0))
            visited.add((0, 0))

            result_sums = []

            # Continue until we have found k_val smallest sums or the heap is empty
            while min_heap and len(result_sums) < k_val:
                current_sum, i, j = heapq.heappop(min_heap)
                result_sums.append(current_sum)

                # Explore moving right in list2 (increment j)
                # Add (list1[i] + list2[j+1]) to the heap if valid and not visited
                if j + 1 < n and (i, j + 1) not in visited:
                    heapq.heappush(min_heap, (list1[i] + list2[j+1], i, j+1))
                    visited.add((i, j+1))

                # Explore moving down in list1 (increment i)
                # Add (list1[i+1] + list2[j]) to the heap if valid and not visited
                if i + 1 < m and (i + 1, j) not in visited:
                    heapq.heappush(min_heap, (list1[i+1] + list2[j], i+1, j))
                    visited.add((i+1, j))

            return result_sums

        # Initialize current_sums with the first row of the matrix.
        # Since we only ever need the k smallest sums, we can truncate the list
        # to at most k elements at each step. The rows are already sorted.
        current_sums = mat[0][:k]

        # Iterate through the rest of the rows, merging the current_sums with each new row
        for r_idx in range(1, len(mat)):
            current_sums = merge_k_smallest_sums(current_sums, mat[r_idx], k)

        # After processing all rows, current_sums will contain the k smallest possible sums
        # The k-th smallest sum is at index k-1 in this sorted list
        return current_sums[k-1]