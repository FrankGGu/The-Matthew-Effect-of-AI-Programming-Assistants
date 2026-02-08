class Solution:
    def recordLampPosts(self, lampPosts: int) -> list[int]:
        lamps = [0] * (lampPosts + 2)
        for i in range(1, lampPosts + 1):
            lamps[i - 1] += 1
            lamps[i] += 1
            lamps[i + 1] += 1

        result = []
        for i in range(1, lampPosts + 1):
            if lamps[i] == 0:
                result.append(i)

        return result