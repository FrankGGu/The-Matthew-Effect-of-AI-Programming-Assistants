import heapq

def maxAndMinSubarrays(nums, k):
    n = len(nums)
    max_heap = []
    min_heap = []
    max_sum = float('-inf')
    min_sum = float('inf')
    curr_sum = 0

    for i in range(n):
        curr_sum += nums[i]
        heapq.heappush(max_heap, nums[i])
        heapq.heappush(min_heap, -nums[i])

        if i >= k:
            curr_sum -= nums[i - k]

            temp_max = max_heap.copy()
            temp_min = min_heap.copy()

            temp_max_list = []
            while temp_max:
                temp_max_list.append(heapq.heappop(temp_max))

            temp_min_list = []
            while temp_min:
                temp_min_list.append(-heapq.heappop(temp_min))

            try:
                temp_max_list.remove(nums[i-k])
            except ValueError:
                pass

            try:
                temp_min_list.remove(nums[i-k])
            except ValueError:
                pass

            max_heap = []
            for val in temp_max_list:
                heapq.heappush(max_heap, val)

            min_heap = []
            for val in temp_min_list:
                heapq.heappush(min_heap, -val)

        if i >= k - 1:
            max_sum = max(max_sum, curr_sum)
            min_sum = min(min_sum, curr_sum)

            max_sum = max(max_sum, sum(heapq.nlargest(k, nums[i-k+1:i+1])))
            min_sum = min(min_sum, sum(heapq.nsmallest(k, nums[i-k+1:i+1])))

    return [max_sum, min_sum]