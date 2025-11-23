import collections

class FrontMiddleBackQueue:

    def __init__(self):
        self.left = collections.deque()
        self.right = collections.deque()

    def _balance(self):
        # Invariant: len(self.left) should be N // 2
        # len(self.right) should be N - N // 2
        # where N = len(self.left) + len(self.right)

        total_len = len(self.left) + len(self.right)
        target_left_len = total_len // 2

        while len(self.left) < target_left_len:
            self.left.append(self.right.popleft())
        while len(self.left) > target_left_len:
            self.right.appendleft(self.left.pop())

    def pushFront(self, val: int) -> None:
        self.left.appendleft(val)
        self._balance()

    def pushMiddle(self, val: int) -> None:
        # If total length N is even (len(left) == len(right)), insert at N/2.
        # This means it becomes the first element of right.
        # Example: [1,2,3,4] -> left=[1,2], right=[3,4]. N=4.
        # pushMiddle(val) -> right.appendleft(val) -> left=[1,2], right=[val,3,4]. Queue [1,2,val,3,4].
        # New N=5. Target left_len=2, right_len=3. Current is 2,3. Balanced.
        #
        # If total length N is odd (len(left) < len(right)), insert at (N-1)/2.
        # This means it becomes the last element of left.
        # Example: [1,2,3,4,5] -> left=[1,2], right=[3,4,5]. N=5.
        # pushMiddle(val) -> left.append(val) -> left=[1,2,val], right=[3,4,5]. Queue [1,2,val,3,4,5].
        # New N=6. Target left_len=3, right_len=3. Current is 3,3. Balanced.
        #
        # In both cases, the state remains balanced for the new total length, so _balance() is not strictly needed.

        if len(self.left) == len(self.right):
            self.right.appendleft(val)
        else: # len(self.left) < len(self.right)
            self.left.append(val)

    def pushBack(self, val: int) -> None:
        self.right.append(val)
        self._balance()

    def popFront(self) -> int:
        if not self.left and not self.right:
            return -1

        res = -1
        if self.left:
            res = self.left.popleft()
        else: # self.right must have elements if not empty
            res = self.right.popleft()

        self._balance()
        return res

    def popMiddle(self) -> int:
        if not self.left and not self.right:
            return -1

        res = -1
        # Problem definition: remove at index (N-1)//2.
        # If N is odd (N=2k+1), index is k. len(left)=k, len(right)=k+1. Element is left[-1].
        # If N is even (N=2k), index is k-1. len(left)=k, len(right)=k. Element is left[-1].
        # So, it's always left.pop() if left is not empty.
        # If left is empty, N must be 1 (N=0 handled by initial check).
        # For N=1, left=[], right=[val]. Index 0 is right[0].

        if self.left:
            res = self.left.pop()
        else: # self.right must have elements if not empty
            res = self.right.popleft()

        self._balance()
        return res

    def popBack(self) -> int:
        if not self.left and not self.right:
            return -1

        res = -1
        if self.right:
            res = self.right.pop()
        else: # self.left must have elements if not empty
            res = self.left.pop()

        self._balance()
        return res