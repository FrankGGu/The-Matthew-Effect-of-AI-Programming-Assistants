class Solution:
    def numOfFlowers(self, flowers: List[List[int]], people: List[int]) -> List[int]:
        timeline = []
        for start, end in flowers:
            timeline.append((start, 1))
            timeline.append((end + 1, -1))

        timeline.sort()

        bloom_count = 0
        bloom_at_time = {}

        for time, change in timeline:
            bloom_count += change
            bloom_at_time[time] = bloom_count

        result = []
        for p in people:
            bloom_count_at_p = 0
            for time, count in bloom_at_time.items():
                if time <= p:
                    bloom_count_at_p = count
                else:
                    break
            result.append(bloom_count_at_p)

        return result