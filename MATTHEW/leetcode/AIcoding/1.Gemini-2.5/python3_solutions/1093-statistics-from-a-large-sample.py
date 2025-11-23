from typing import List

class Solution:
    def sampleStats(self, count: List[int]) -> List[float]:
        min_val = -1
        max_val = -1
        total_sum = 0
        total_count = 0
        max_freq = 0
        mode_val = 0

        for x in range(256):
            c = count[x]
            if c > 0:
                if min_val == -1:
                    min_val = x
                max_val = x

                total_sum += x * c
                total_count += c

                if c > max_freq:
                    max_freq = c
                    mode_val = x

        if total_count == 0:
            return [0.0, 0.0, 0.0, 0.0, 0.0]

        mean_val = float(total_sum) / total_count

        median_val = 0.0
        current_count_sum = 0

        if total_count % 2 == 1:
            target_index = total_count // 2
            for x in range(256):
                current_count_sum += count[x]
                if current_count_sum > target_index:
                    median_val = float(x)
                    break
        else:
            target_index_1 = total_count // 2 - 1
            target_index_2 = total_count // 2

            val1 = -1
            val2 = -1

            for x in range(256):
                current_count_sum += count[x]
                if val1 == -1 and current_count_sum > target_index_1:
                    val1 = x
                if val2 == -1 and current_count_sum > target_index_2:
                    val2 = x
                    break
            median_val = (float(val1) + float(val2)) / 2.0

        return [float(min_val), float(max_val), mean_val, median_val, float(mode_val)]