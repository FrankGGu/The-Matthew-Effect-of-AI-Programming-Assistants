class Solution:
    def maxCandies(self, boxes: List[int], keys: List[int], locked: List[int], initialBoxes: List[int]) -> int:
        n = len(boxes)
        q = deque(initialBoxes)
        has_key = [0] * n
        visited = [0] * n
        ans = 0

        for i in range(n):
            has_key[i] = keys[i]

        while q:
            box_idx = q.popleft()

            if visited[box_idx]:
                continue

            visited[box_idx] = 1

            if locked[box_idx] == 0 or has_key[box_idx] == 1:
                ans += boxes[box_idx]

                for i in range(n):
                    if i not in q and i not in initialBoxes and visited[i] == 0:
                        if has_key[i] == 1:
                            q.append(i)

                for i in range(n):
                    if i != box_idx:
                        has_key[i] = has_key[i] or keys[box_idx]

                for i in range(n):
                    if i not in q and i not in initialBoxes and visited[i] == 0 and locked[i] == 0:
                        q.append(i)

                for i in range(n):
                    if i not in q and i not in initialBoxes and visited[i] == 0 and locked[i] == 1 and has_key[i] == 1:
                        q.append(i)

            else:

                can_unlock = False
                for i in range(n):
                    if i in q:
                        if has_key[box_idx] == 1:
                            can_unlock = True
                            break

                if can_unlock:
                  q.append(box_idx)

                else:
                    continue

        return ans