class Solution:
    def numberOfStrings(self, n: int) -> int:
        # Total number of strings of length n using 'a', 'b', 'c' is 3^n.
        # We want to count strings that contain at least one 'a', at least one 'b', and at least one 'c'.
        # This can be solved using the Principle of Inclusion-Exclusion.

        # Let S be the set of all strings of length n. |S| = 3^n.
        # Let A be the set of strings that do NOT contain 'a'. (Uses only 'b', 'c'). |A| = 2^n.
        # Let B be the set of strings that do NOT contain 'b'. (Uses only 'a', 'c'). |B| = 2^n.
        # Let C be the set of strings that do NOT contain 'c'. (Uses only 'a', 'b'). |C| = 2^n.

        # We want to find |S| - |A U B U C|.

        # By Inclusion-Exclusion Principle:
        # |A U B U C| = |A| + |B| + |C| - (|A ∩ B| + |A ∩ C| + |B ∩ C|) + |A ∩ B ∩ C|

        # |A ∩ B|: Strings that do NOT contain 'a' AND do NOT contain 'b'. (Uses only 'c'). |A ∩ B| = 1^n = 1.
        # |A ∩ C|: Strings that do NOT contain 'a' AND do NOT contain 'c'. (Uses only 'b'). |A ∩ C| = 1^n = 1.
        # |B ∩ C|: Strings that do NOT contain 'b' AND do NOT contain 'c'. (Uses only 'a'). |B ∩ C| = 1^n = 1.

        # |A ∩ B ∩ C|: Strings that do NOT contain 'a', 'b', AND 'c'. (Uses none). This is 0 for n >= 1.

        # Substitute these values:
        # |A U B U C| = (2^n + 2^n + 2^n) - (1 + 1 + 1) + 0
        # |A U B U C| = 3 * (2^n) - 3

        # The number of strings that contain at least one 'a', 'b', and 'c' is:
        # |S| - |A U B U C| = 3^n - (3 * 2^n - 3)
        # = 3^n - 3 * 2^n + 3

        # This formula is valid for n >= 1.
        # For n=1: 3^1 - 3*2^1 + 3 = 3 - 6 + 3 = 0. Correct.
        # For n=2: 3^2 - 3*2^2 + 3 = 9 - 12 + 3 = 0. Correct.
        # For n=3: 3^3 - 3*2^3 + 3 = 27 - 24 + 3 = 6. Correct (abc, acb, bac, bca, cab, cba).

        return 3**n - 3 * (2**n) + 3