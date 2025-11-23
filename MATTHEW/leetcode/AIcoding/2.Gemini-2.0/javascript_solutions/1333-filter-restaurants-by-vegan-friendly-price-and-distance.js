var filterRestaurants = function(restaurants, veganFriendly, maxPrice, maxDistance) {
    let filteredRestaurants = restaurants.filter(restaurant => {
        if (veganFriendly === 1 && restaurant[2] === 0) {
            return false;
        }
        if (restaurant[3] > maxPrice || restaurant[4] > maxDistance) {
            return false;
        }
        return true;
    });

    filteredRestaurants.sort((a, b) => {
        if (b[1] !== a[1]) {
            return b[1] - a[1];
        } else {
            return b[0] - a[0];
        }
    });

    let result = [];
    for (let restaurant of filteredRestaurants) {
        result.push(restaurant[0]);
    }

    return result;
};