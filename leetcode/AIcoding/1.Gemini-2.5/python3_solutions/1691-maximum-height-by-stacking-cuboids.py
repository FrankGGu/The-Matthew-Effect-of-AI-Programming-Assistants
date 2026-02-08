class Solution:
    def maxHeight(self, cuboids: list[list[int]]) -> int:

        normalized_cuboids = []
        for cuboid in cuboids:
            cuboid.sort()
            normalized_cuboids.append(cuboid)

        normalized_cuboids.sort(key=lambda x: (-x[0], -x[1], -x[2]))

        n = len(normalized_cuboids)

        dp = [cuboid[2] for cuboid in normalized_cuboids]

        for i in range(n):
            for j in range(i):
                if normalized_cuboids[i][0] <= normalized_cuboids[j][0] and \
                   normalized_cuboids[i][1] <= normalized_cuboids[j][1]:
                    dp[i] = max(dp[i], normalized_cuboids[i][2] + dp[j])

        return max(dp) if dp else 0