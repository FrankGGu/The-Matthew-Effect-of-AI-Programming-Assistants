import random

class RandomizedCollection:

    def __init__(self):
        """
        Initialize your data structure here.
        """
        self.nums = []  # Stores all elements, including duplicates
        self.val_to_indices = {} # Maps value to a set of indices where it appears in self.nums

    def insert(self, val: int) -> bool:
        """
        Inserts a value to the collection. Returns true if the collection did not already contain the specified element.
        """
        # Check if this is the first instance of 'val' being inserted
        # (i.e., its entry in val_to_indices is empty or doesn't exist)
        was_new = val not in self.val_to_indices or not self.val_to_indices[val]

        # Add the current index to the set associated with 'val'
        # The index will be the current length of nums, as it's about to be appended
        self.val_to_indices.setdefault(val, set()).add(len(self.nums))

        # Append the value to the list
        self.nums.append(val)

        return was_new

    def remove(self, val: int) -> bool:
        """
        Removes a value from the collection. Returns true if the collection contained the specified element.
        """
        # If 'val' is not in the dictionary or its set of indices is empty, it's not in the collection
        if val not in self.val_to_indices or not self.val_to_indices[val]:
            return False

        # Get an arbitrary index for 'val' to be removed
        idx_to_remove = self.val_to_indices[val].pop()

        # Get the last element in the list and its index
        last_val = self.nums[-1]
        last_idx = len(self.nums) - 1

        # If the element to remove is not the last element
        if idx_to_remove != last_idx:
            # Overwrite the element at idx_to_remove with the last element
            self.nums[idx_to_remove] = last_val

            # Update the index set for 'last_val':
            # Remove its old index (last_idx) and add its new index (idx_to_remove)
            self.val_to_indices[last_val].remove(last_idx)
            self.val_to_indices[last_val].add(idx_to_remove)

        # Remove the last element from the list (it's either the one we wanted to remove,
        # or it's been moved to replace another element and now needs to be truly removed from the end)
        self.nums.pop()

        # If there are no more instances of 'val' left, remove its entry from the dictionary
        if not self.val_to_indices[val]:
            del self.val_to_indices[val]

        return True

    def getRandom(self) -> int:
        """
        Get a random element from the collection.
        """
        # random.choice works in O(1) average time for lists
        return random.choice(self.nums)