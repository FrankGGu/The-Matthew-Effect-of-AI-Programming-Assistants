import heapq

class Solution:
    def getNumberOfBacklogOrders(self, orders: list[list[int]]) -> int:
        buy_backlog = []  # Max-heap for buy orders: (-price, amount)
        sell_backlog = [] # Min-heap for sell orders: (price, amount)

        MOD = 10**9 + 7

        for price, amount, order_type in orders:
            if order_type == 0:  # Buy order
                # Try to fulfill with sell orders (cheapest first)
                while amount > 0 and sell_backlog and sell_backlog[0][0] <= price:
                    sell_price, sell_amount = heapq.heappop(sell_backlog)

                    if sell_amount <= amount:
                        amount -= sell_amount
                    else: # sell_amount > amount, current buy order is fully fulfilled
                        sell_amount -= amount
                        heapq.heappush(sell_backlog, (sell_price, sell_amount))
                        amount = 0 

                if amount > 0: # If there's remaining buy amount, add to buy backlog
                    heapq.heappush(buy_backlog, (-price, amount))

            else: # order_type == 1, Sell order
                # Try to fulfill with buy orders (most expensive first)
                while amount > 0 and buy_backlog and -buy_backlog[0][0] >= price:
                    buy_price_neg, buy_amount = heapq.heappop(buy_backlog)

                    if buy_amount <= amount:
                        amount -= buy_amount
                    else: # buy_amount > amount, current sell order is fully fulfilled
                        buy_amount -= amount
                        heapq.heappush(buy_backlog, (buy_price_neg, buy_amount))
                        amount = 0 

                if amount > 0: # If there's remaining sell amount, add to sell backlog
                    heapq.heappush(sell_backlog, (price, amount))

        total_backlog_amount = 0

        for _, amount in buy_backlog:
            total_backlog_amount += amount

        for _, amount in sell_backlog:
            total_backlog_amount += amount

        return total_backlog_amount % MOD