import collections

class Solution:
    def deliverBoxes(self, boxes: list[list[int]], ports: int, maxBoxes: int, maxWeight: int) -> int:
        N = len(boxes)

        prefix_weights = [0] * (N + 1)
        for k in range(N):
            prefix_weights[k+1] = prefix_weights[k] + boxes[k][0]

        prefix_port_changes = [0] * (N + 1)
        for k in range(1, N):
            prefix_port_changes[k+1] = prefix_port_changes[k] + (1 if boxes[k][1] != boxes[k-1][1] else 0)

        dp = [float('inf')] * (N + 1)
        dp[0] = 0

        deque = collections.deque()
        deque.append(0)

        left_ptr_for_weight = 0

        for i in range(1, N + 1):
            while deque and deque[0] < i - maxBoxes:
                deque.popleft()

            while left_ptr_for_weight < i and prefix_weights[i] - prefix_weights[left_ptr_for_weight] > maxWeight:
                left_ptr_for_weight += 1

            while deque and deque[0] < left_ptr_for_weight:
                deque.popleft()

            dp[i] = dp[deque[0]] + 1 + prefix_port_changes[i] - prefix_port_changes[deque[0]+1]

            if i < N:
                while deque and (dp[deque[-1]] - prefix_port_changes[deque[-1]+1]) >= (dp[i] - prefix_port_changes[i+1]):
                    deque.pop()
                deque.append(i)

        return dp[N]