from collections import deque

class Solution:
    def minReverseOperations(self, n: int, p: int, banned: list[int], k: int) -> list[int]:
        banned_set = set(banned)
        result = [-1] * n
        result[p] = 0

        even_nums = set()
        odd_nums = set()

        for i in range(n):
            if i not in banned_set and i != p:
                if i % 2 == 0:
                    even_nums.add(i)
                else:
                    odd_nums.add(i)

        even_queue = deque()
        odd_queue = deque()

        if p % 2 == 0 and even_nums:
            even_queue.append(p)
        elif p % 2 != 0 and odd_nums:
            odd_queue.append(p)

        while even_queue or odd_queue:

            if even_queue:
                curr = even_queue.popleft()

                reachable = []

                l = max(0, curr - (k - 1))
                r = min(n - 1, curr + (k - 1))

                min_val = max(0, curr - (k - 1) + abs((curr - (k - 1)) - curr))
                max_val = min(n - 1, curr + (k - 1) - abs((curr + (k - 1)) - curr))

                to_remove = []
                for neighbor in list(even_nums):
                    if min_val <= neighbor <= max_val and abs(neighbor - curr) <= k - 1 and neighbor != curr:
                        reachable.append(neighbor)
                        result[neighbor] = result[curr] + 1
                        even_queue.append(neighbor)
                        to_remove.append(neighbor)

                for node in to_remove:
                    even_nums.remove(node)

            if odd_queue:
                curr = odd_queue.popleft()

                reachable = []

                l = max(0, curr - (k - 1))
                r = min(n - 1, curr + (k - 1))

                min_val = max(0, curr - (k - 1) + abs((curr - (k - 1)) - curr))
                max_val = min(n - 1, curr + (k - 1) - abs((curr + (k - 1)) - curr))

                to_remove = []
                for neighbor in list(odd_nums):
                    if min_val <= neighbor <= max_val and abs(neighbor - curr) <= k - 1 and neighbor != curr:
                        reachable.append(neighbor)
                        result[neighbor] = result[curr] + 1
                        odd_queue.append(neighbor)
                        to_remove.append(neighbor)

                for node in to_remove:
                    odd_nums.remove(node)

        return result