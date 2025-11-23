class Solution:
    def countCollisions(self, directions: str) -> int:
        n = len(directions)

        # Find the index of the first character that is not 'L'.
        # All 'L' cars before this index escape off the left end without colliding.
        left = 0
        while left < n and directions[left] == 'L':
            left += 1

        # Find the index of the last character that is not 'R'.
        # All 'R' cars after this index escape off the right end without colliding.
        right = n - 1
        while right >= 0 and directions[right] == 'R':
            right -= 1

        # If the left pointer has crossed or met the right pointer,
        # it means all cars have either escaped or the string was empty/contained only 'S' cars
        # that don't cause collisions by themselves.
        if left > right:
            return 0

        collisions = 0
        # In the remaining segment (directions[left : right+1]),
        # any 'R' or 'L' car is guaranteed to collide.
        # An 'R' car will collide with an 'S' or 'L' to its right.
        # An 'L' car will collide with an 'S' or 'R' to its left.
        # An 'S' car acts as a barrier, causing collisions for 'R' and 'L' cars.
        # Each 'R' or 'L' car that collides contributes 1 to the total collision count.
        for i in range(left, right + 1):
            if directions[i] == 'R' or directions[i] == 'L':
                collisions += 1

        return collisions