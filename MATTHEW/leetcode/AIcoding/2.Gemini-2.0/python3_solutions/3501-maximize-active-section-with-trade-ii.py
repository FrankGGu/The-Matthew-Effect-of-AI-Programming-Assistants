def maximizeActiveSection(charges: list[int], recharge: int, start: int) -> int:
    n = len(charges)
    dp = {}

    def solve(index, current_charge):
        if index == n:
            return 0

        if (index, current_charge) in dp:
            return dp[(index, current_charge)]

        # Option 1: Use the charge
        use_charge = 0
        if current_charge >= charges[index]:
            use_charge = 1 + solve(index + 1, current_charge - charges[index])

        # Option 2: Recharge
        recharge_val = solve(index + 1, recharge)

        dp[(index, current_charge)] = max(use_charge, recharge_val)
        return dp[(index, current_charge)]

    return solve(0, start)