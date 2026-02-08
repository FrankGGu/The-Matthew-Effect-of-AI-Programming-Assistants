class Solution:
    def sampleStats(self, count: List[int]) -> List[float]:
        total = sum(count)
        mean = 0.0
        min_val = -1
        max_val = -1
        mode = 0
        max_count = 0
        sum_all = 0

        for i in range(256):
            if count[i] > 0:
                if min_val == -1:
                    min_val = i
                max_val = i
                sum_all += i * count[i]
                if count[i] > max_count:
                    max_count = count[i]
                    mode = i

        mean = sum_all / total

        median = 0.0
        half = total // 2
        if total % 2 == 1:
            cnt = 0
            for i in range(256):
                cnt += count[i]
                if cnt > half:
                    median = i
                    break
        else:
            cnt = 0
            first = -1
            second = -1
            for i in range(256):
                cnt += count[i]
                if first == -1 and cnt >= half:
                    first = i
                if cnt >= half + 1:
                    second = i
                    break
            median = (first + second) / 2

        return [float(min_val), float(max_val), mean, median, float(mode)]