class Solution:
    def maxCandies(self, status: List[int], candies: List[int], keys: List[List[int]], containedBoxes: List[List[int]], initialBoxes: List[int]) -> int:
        from collections import deque

        queue = deque()
        owned_boxes = set(initialBoxes)
        found_keys = set()
        total_candies = 0

        for box in initialBoxes:
            if status[box] == 1:
                queue.append(box)

        while queue:
            current_box = queue.popleft()
            total_candies += candies[current_box]

            for key in keys[current_box]:
                found_keys.add(key)
                if key in owned_boxes and key not in queue:
                    queue.append(key)

            for box in containedBoxes[current_box]:
                owned_boxes.add(box)
                if status[box] == 1 or box in found_keys:
                    if box not in queue:
                        queue.append(box)

        return total_candies