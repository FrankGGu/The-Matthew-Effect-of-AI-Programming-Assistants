def maxEnergyBoost(drinks):
    drinks.sort(reverse=True)
    return drinks[0] + drinks[1]