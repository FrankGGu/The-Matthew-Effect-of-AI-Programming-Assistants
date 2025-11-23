class Solution:
    def gemSupply(self, cups: list[int], operations: list[list[int]]) -> list[int]:
        for op in operations:
            from_idx, to_idx = op[0], op[1]

            transfer_amount = cups[from_idx] // 2

            cups[from_idx] -= transfer_amount
            cups[to_idx] += transfer_amount

        return cups