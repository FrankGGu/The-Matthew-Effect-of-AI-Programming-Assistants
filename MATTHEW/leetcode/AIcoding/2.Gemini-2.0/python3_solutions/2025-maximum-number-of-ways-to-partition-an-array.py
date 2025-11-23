class Solution:
    def waysToPartition(self, nums: List[int], k: int) -> int:
        n = len(nums)
        total_sum = sum(nums)
        prefix_sum = [0] * n
        prefix_sum[0] = nums[0]
        for i in range(1, n):
            prefix_sum[i] = prefix_sum[i - 1] + nums[i]

        count = 0
        for i in range(n - 1):
            if prefix_sum[i] == total_sum - prefix_sum[i]:
                count += 1

        diff_count = {}
        for i in range(n):
            diff = nums[i] - k
            if diff not in diff_count:
                diff_count[diff] = 0
            diff_count[diff] += 1

        ans = count
        for i in range(n - 1):
            diff = nums[i] - k

            target_sum = prefix_sum[i] + diff

            if (total_sum - nums[i] + k ) % 2 == 0:

                if (total_sum - nums[i] + k) / 2 == (prefix_sum[-1] - prefix_sum[i]):

                    if -diff in diff_count:
                        ans = max(ans, count + diff_count.get(-diff, 0))
                    else:
                         ans = max(ans, count)

            if prefix_sum[i] - diff * 2 == 0 :
                if diff in diff_count:
                    ans= max(ans, count + diff_count.get(diff,0))
                else:
                    ans = max(ans, count)

            temp_count = 0
            for j in range(n-1):
                if prefix_sum[j] - diff == (total_sum - prefix_sum[j]) + diff:
                    temp_count +=1
            if diff in diff_count:
                ans = max(ans, temp_count)
            else:
                ans = max(ans, count)

        change_count = 0
        for i in range(n-1):
            if (prefix_sum[i] + (nums[i] -k)) == (total_sum - prefix_sum[i] - (nums[i] -k)):
                change_count +=1

        original_count = 0
        for i in range(n-1):
            if prefix_sum[i] == (total_sum - prefix_sum[i]):
                 original_count +=1

        change_count_map = {}
        for i in range(n):
            temp_sum = 0
            temp_count = 0
            for j in range(n-1):
                if prefix_sum[j] - (nums[i] - k) == (total_sum - prefix_sum[j]) + (nums[i] - k):
                    temp_count +=1

            change_count_map[i] = temp_count
        if change_count_map:

            ans = max(original_count, max(change_count_map.values()))
        else:
            ans = original_count

        temp_count = 0
        for j in range(n-1):
            if prefix_sum[j] == total_sum - prefix_sum[j]:
                temp_count +=1
        ans_temp = 0
        for i in range(n):
            temp_count_1 = 0
            for j in range(n-1):
                if prefix_sum[j] + (nums[i] - k) == total_sum - prefix_sum[j] - (nums[i] - k):
                    temp_count_1 +=1
            ans_temp = max(ans_temp, temp_count_1)

        ans = max(ans, ans_temp)

        temp_count = 0
        for i in range(n-1):
            if prefix_sum[i] == total_sum - prefix_sum[i]:
                temp_count +=1
        ans = max(ans, temp_count)

        return ans