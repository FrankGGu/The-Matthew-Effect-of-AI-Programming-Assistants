import random

class RandomizedSet:

    def __init__(self):
        """
        Initialize your data structure here.
        """
        self.nums = []
        self.val_to_index = {} # val -> index in self.nums

    def insert(self, val: int) -> bool:
        """
        Inserts a value to the set. Returns true if the set did not already contain the specified element.
        """
        if val in self.val_to_index:
            return False

        self.val_to_index[val] = len(self.nums)
        self.nums.append(val)
        return True

    def remove(self, val: int) -> bool:
        """
        Removes a value from the set. Returns true if the set contained the specified element.
        """
        if val not in self.val_to_index:
            return False

        # Get the index of the value to be removed
        idx_to_remove = self.val_to_index[val]

        # Get the last element in the list
        last_val = self.nums[-1]

        # Move the last element to the position of the element to be removed
        self.nums[idx_to_remove] = last_val
        # Update the index of the last_val in the hash map
        self.val_to_index[last_val] = idx_to_remove

        # Remove the last element from the list (it's now duplicated at idx_to_remove)
        self.nums.pop()
        # Remove the val from the hash map
        del self.val_to_index[val]

        return True

    def getRandom(self) -> int:
        """
        Get a random element from the set.
        """
        return random.choice(self.nums)