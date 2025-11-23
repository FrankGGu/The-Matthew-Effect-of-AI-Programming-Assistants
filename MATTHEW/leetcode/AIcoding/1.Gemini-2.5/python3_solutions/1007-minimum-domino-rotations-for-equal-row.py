class Solution:
    def minDominoRotations(self, tops: list[int], bottoms: list[int]) -> int:
        n = len(tops)

        def check(x):
            rotations_to_make_tops_x = 0
            rotations_to_make_bottoms_x = 0

            for i in range(n):
                # If neither tops[i] nor bottoms[i] is x, then it's impossible
                # to make a row of x.
                if tops[i] != x and bottoms[i] != x:
                    return -1

                # If tops[i] is not x, we must rotate this domino
                # to put bottoms[i] (which must be x) into tops.
                if tops[i] != x:
                    rotations_to_make_tops_x += 1

                # If bottoms[i] is not x, we must rotate this domino
                # to put tops[i] (which must be x) into bottoms.
                if bottoms[i] != x:
                    rotations_to_make_bottoms_x += 1

            # Return the minimum rotations needed for either tops or bottoms to be all x
            return min(rotations_to_make_tops_x, rotations_to_make_bottoms_x)

        # Try to make a row of tops[0]
        res1 = check(tops[0])

        # Try to make a row of bottoms[0]
        # If tops[0] == bottoms[0], this will calculate the same result as res1, which is fine.
        res2 = check(bottoms[0])

        # If both attempts failed, return -1
        if res1 == -1 and res2 == -1:
            return -1
        # If only one attempt failed, return the result of the successful one
        elif res1 == -1:
            return res2
        elif res2 == -1:
            return res1
        # If both attempts were successful, return the minimum of the two
        else:
            return min(res1, res2)