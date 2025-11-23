import heapq

class Solution:
    def getNumberOfBacklogOrders(self, orders: List[List[int]]) -> int:
        buyOrders = []
        sellOrders = []

        for price, amount, orderType in orders:
            if orderType == 0:
                while sellOrders and price >= sellOrders[0][0] and amount > 0:
                    sellPrice, sellAmount = heapq.heappop(sellOrders)

                    if amount >= sellAmount:
                        amount -= sellAmount
                    else:
                        sellAmount -= amount
                        heapq.heappush(sellOrders, (sellPrice, sellAmount))
                        amount = 0

                if amount > 0:
                    heapq.heappush(buyOrders, (-price, amount))
            else:
                while buyOrders and price <= -buyOrders[0][0] and amount > 0:
                    buyPrice, buyAmount = heapq.heappop(buyOrders)
                    buyPrice = -buyPrice

                    if amount >= buyAmount:
                        amount -= buyAmount
                    else:
                        buyAmount -= amount
                        heapq.heappush(buyOrders, (-buyPrice, buyAmount))
                        amount = 0

                if amount > 0:
                    heapq.heappush(sellOrders, (price, amount))

        totalOrders = 0
        for _, amount in buyOrders:
            totalOrders += amount
        for _, amount in sellOrders:
            totalOrders += amount

        return totalOrders % (10**9 + 7)