import collections

class Solution:
    def maxCandies(self, status: list[int], candies: list[int], keys: list[list[int]], containedBoxes: list[list[int]], initialBoxes: list[int]) -> int:
        n = len(status)

        total_candies = 0

        q = collections.deque()

        opened = [False] * n
        has_key = [False] * n
        found = [False] * n

        for i in range(n):
            if status[i] == 1:
                has_key[i] = True

        for box_idx in initialBoxes:
            found[box_idx] = True
            if has_key[box_idx]:
                q.append(box_idx)

        while q:
            curr_box = q.popleft()

            if opened[curr_box]:
                continue

            opened[curr_box] = True
            total_candies += candies[curr_box]

            for key_idx in keys[curr_box]:
                has_key[key_idx] = True
                if found[key_idx] and not opened[key_idx]:
                    q.append(key_idx)

            for contained_idx in containedBoxes[curr_box]:
                found[contained_idx] = True
                if has_key[contained_idx] and not opened[contained_idx]:
                    q.append(contained_idx)

        return total_candies