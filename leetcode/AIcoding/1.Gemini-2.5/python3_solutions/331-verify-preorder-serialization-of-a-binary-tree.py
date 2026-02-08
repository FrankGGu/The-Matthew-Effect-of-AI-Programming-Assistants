class Solution:
    def isValidSerialization(self, preorder: str) -> bool:
        nodes = preorder.split(',')

        # 'diff' represents the number of available slots for children.
        # A non-null node consumes 1 slot and provides 2 new slots.
        # A null node ('#') consumes 1 slot and provides 0 new slots.
        # We start with 1 slot for the root of the tree.
        diff = 1 

        for node in nodes:
            # Each node, whether null or non-null, consumes one available slot.
            diff -= 1

            # If 'diff' becomes negative at any point, it means we tried to place
            # a node where no slot was available, indicating an invalid structure.
            if diff < 0:
                return False

            # If the current node is not '#', it's a non-null node.
            # A non-null node provides two new slots for its children.
            if node != '#':
                diff += 2

        # After processing all nodes, a valid serialization must have 'diff' equal to 0.
        # This means all slots were perfectly filled, and the tree is complete.
        return diff == 0