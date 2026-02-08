class Solution:
    def minimumTimeToBreakLocks(self, locks: int, keyPresses: int) -> int:
        return (locks + keyPresses - 1) // keyPresses