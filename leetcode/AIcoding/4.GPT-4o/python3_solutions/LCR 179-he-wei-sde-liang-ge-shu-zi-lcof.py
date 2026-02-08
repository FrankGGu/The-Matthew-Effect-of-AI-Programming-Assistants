def twoSum(prices, target):
    price_map = {}
    for i, price in enumerate(prices):
        complement = target - price
        if complement in price_map:
            return [price_map[complement], i]
        price_map[price] = i
    return []