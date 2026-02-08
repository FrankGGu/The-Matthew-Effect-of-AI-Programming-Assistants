class Solution:
    def sampleStats(self, count: List[int]) -> List[float]:
        n = len(count)
        min_val = -1
        max_val = -1
        total_sum = 0
        total_count = 0
        mode = -1
        mode_count = 0

        for i in range(n):
            if count[i] > 0:
                if min_val == -1:
                    min_val = i
                max_val = i
                total_sum += i * count[i]
                total_count += count[i]
                if count[i] > mode_count:
                    mode_count = count[i]
                    mode = i

        mean = total_sum / total_count

        median = 0
        cumulative_count = 0

        if total_count % 2 == 0:
            first_median = -1
            second_median = -1

            for i in range(n):
                cumulative_count += count[i]
                if first_median == -1 and cumulative_count >= total_count / 2:
                    first_median = i
                if second_median == -1 and cumulative_count >= total_count / 2 + 1:
                    second_median = i
                    break

            median = (first_median + second_median) / 2
        else:
            for i in range(n):
                cumulative_count += count[i]
                if cumulative_count >= (total_count + 1) / 2:
                    median = i
                    break

        return [min_val, max_val, mean, median, mode]