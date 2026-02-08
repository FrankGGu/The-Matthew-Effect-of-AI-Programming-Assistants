class Solution:
    def maxSatisfied(self, customers: list[int], grumpy: list[int], minutes: int) -> int:
        n = len(customers)

        base_customers = 0
        for i in range(n):
            if grumpy[i] == 0:
                base_customers += customers[i]

        max_additional_customers = 0
        current_additional_customers = 0

        # Calculate additional customers for the first window of 'minutes'
        for i in range(minutes):
            if grumpy[i] == 1:
                current_additional_customers += customers[i]

        max_additional_customers = current_additional_customers

        # Slide the window
        for i in range(minutes, n):
            # Remove the customer leaving the window (leftmost)
            if grumpy[i - minutes] == 1:
                current_additional_customers -= customers[i - minutes]

            # Add the customer entering the window (rightmost)
            if grumpy[i] == 1:
                current_additional_customers += customers[i]

            max_additional_customers = max(max_additional_customers, current_additional_customers)

        return base_customers + max_additional_customers