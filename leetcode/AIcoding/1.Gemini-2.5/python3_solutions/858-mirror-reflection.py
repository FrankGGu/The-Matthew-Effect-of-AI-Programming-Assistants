import math

class Solution:
    def mirrorReflection(self, p: int, q: int) -> int:
        # Calculate the greatest common divisor of p and q.
        # This simplifies the problem by finding the smallest equivalent room dimensions
        # where the beam hits a corner.
        g = math.gcd(p, q)

        # p_prime represents the number of horizontal 'room traversals'
        # q_prime represents the number of vertical 'room traversals'
        # in the unfolded grid until the beam hits a corner.
        # These p_prime and q_prime values will be coprime.
        p_prime = p // g
        q_prime = q // g

        # Analyze the parity of p_prime and q_prime to determine which receiver is hit.

        # If p_prime is even, the beam effectively ends up on the left wall (x=0)
        # in the original room's coordinate system after all reflections.
        # Since p_prime and q_prime are coprime, if p_prime is even, q_prime must be odd.
        # An odd q_prime means it ends up on the top wall (y=p).
        # Thus, it hits (0, p), which is Receiver 2.
        if p_prime % 2 == 0:
            return 2

        # If p_prime is odd, the beam effectively ends up on the right wall (x=p)
        # in the original room's coordinate system after all reflections.
        else: # p_prime % 2 == 1
            # If q_prime is odd, it ends up on the top wall (y=p).
            # Thus, it hits (p, p), which is Receiver 1.
            if q_prime % 2 == 1:
                return 1
            # If q_prime is even, it ends up on the bottom wall (y=0).
            # Thus, it hits (p, 0), which is Receiver 0.
            else: # q_prime % 2 == 0
                return 0