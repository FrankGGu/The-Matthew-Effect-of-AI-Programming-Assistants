import random

class RandomizedSet:

    def __init__(self):
        self.nums = []
        self.val_to_index = {}

    def insert(self, val: int) -> bool:
        if val in self.val_to_index:
            return False

        self.nums.append(val)
        self.val_to_index[val] = len(self.nums) - 1
        return True

    def remove(self, val: int) -> bool:
        if val not in self.val_to_index:
            return False

        idx_to_remove = self.val_to_index[val]
        last_val = self.nums[-1]

        # Move the last element to the position of the element to be removed
        self.nums[idx_to_remove] = last_val
        self.val_to_index[last_val] = idx_to_remove

        # Remove the element (now at the end) and its entry from the map
        self.nums.pop()
        del self.val_to_index[val]

        return True

    def getRandom(self) -> int:
        return random.choice(self.nums)