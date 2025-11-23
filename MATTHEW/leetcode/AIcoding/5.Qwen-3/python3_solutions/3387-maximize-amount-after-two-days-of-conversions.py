class Solution:
    def maxAmount(self, coins: List[str], rates: List[List[str]]) -> str:
        from collections import defaultdict

        rate_map = defaultdict(dict)
        for rate in rates:
            from_coin, to_coin, value = rate
            rate_map[from_coin][to_coin] = float(value)

        def convert(amount, coin):
            if coin not in rate_map:
                return amount
            max_amount = amount
            for next_coin in rate_map[coin]:
                converted = convert(amount * rate_map[coin][next_coin], next_coin)
                if converted > max_amount:
                    max_amount = converted
            return max_amount

        max_total = 0.0
        for coin in rate_map:
            total = convert(float(1), coin)
            if total > max_total:
                max_total = total

        return f"{max_total:.2f}"