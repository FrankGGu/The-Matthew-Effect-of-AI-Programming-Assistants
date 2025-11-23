class Fancy:

    def __init__(self):
        self.MOD = 10**9 + 7
        self.seq = []  # Stores (original_val, current_mult_at_append, current_add_at_append)
        self.current_mult = 1
        self.current_add = 0

    def append(self, val: int) -> None:
        self.seq.append((val, self.current_mult, self.current_add))

    def addAll(self, inc: int) -> None:
        self.current_add = (self.current_add + inc) % self.MOD

    def multAll(self, m: int) -> None:
        self.current_mult = (self.current_mult * m) % self.MOD
        self.current_add = (self.current_add * m) % self.MOD

    def getIndex(self, idx: int) -> int:
        if idx >= len(self.seq):
            return -1

        original_val, M_at_append, A_at_append = self.seq[idx]

        # We are looking for a transformation (M_diff, A_diff) such that:
        # M_at_append * M_diff = self.current_mult (mod MOD)
        # A_at_append * M_diff + A_diff = self.current_add (mod MOD)

        # Calculate M_diff
        # M_at_append is always >= 1 (since current_mult starts at 1 and is multiplied by m >= 1),
        # so its modular inverse exists.
        M_at_append_inv = pow(M_at_append, self.MOD - 2, self.MOD)
        M_diff = (self.current_mult * M_at_append_inv) % self.MOD

        # Calculate A_diff
        # A_diff = (self.current_add - A_at_append * M_diff) % MOD
        # Ensure result is non-negative by adding MOD before taking modulo
        A_diff = (self.current_add - (A_at_append * M_diff) % self.MOD + self.MOD) % self.MOD

        # Apply this derived transformation (M_diff, A_diff) to the original_val
        final_val = (original_val * M_diff + A_diff) % self.MOD

        return final_val