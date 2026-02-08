function filterRestaurants(restaurants, veganFriendly, maxPrice, maxDistance) {
    return restaurants.filter(r => {
        return (!veganFriendly || r[2]) && r[3] <= maxPrice && r[4] <= maxDistance;
    }).sort((a, b) => b[1] - a[1] || b[0] - a[0]);
}