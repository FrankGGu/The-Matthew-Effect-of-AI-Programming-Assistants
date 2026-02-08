class Solution:
    def boxDelivering(self, boxes: List[List[int]], portsCount: int, maxBoxes: int, maxWeight: int) -> int:
        n = len(boxes)
        prefix_weight = [0] * (n + 1)
        for i in range(n):
            prefix_weight[i + 1] = prefix_weight[i] + boxes[i][1]

        dp = [float('inf')] * (n + 1)
        dp[0] = 0

        for i in range(1, n + 1):
            weight = 0
            boxes_count = 0
            last_port = boxes[i - 1][0]
            for j in range(i, 0, -1):
                weight += boxes[j - 1][1]
                if boxes[j - 1][0] != last_port:
                    last_port = boxes[j - 1][0]
                boxes_count += 1
                if boxes_count > maxBoxes or weight > maxWeight:
                    break
                dp[i] = min(dp[i], dp[j - 1] + 1)

        return dp[n]