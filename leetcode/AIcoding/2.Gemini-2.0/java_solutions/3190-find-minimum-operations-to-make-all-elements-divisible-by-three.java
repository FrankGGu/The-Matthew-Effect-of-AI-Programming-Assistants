class Solution {
    public int minOperations(int[] nums) {
        int sum = 0;
        int min1 = Integer.MAX_VALUE;
        int min2 = Integer.MAX_VALUE;

        for (int num : nums) {
            sum += num % 3;
            sum %= 3;

            if (num % 3 == 1) {
                min1 = Math.min(min1, num);
            } else if (num % 3 == 2) {
                min2 = Math.min(min2, num);
            }
        }

        if (sum == 0) {
            return 0;
        } else if (sum == 1) {
            if (min1 != Integer.MAX_VALUE) {
                if (min2 != Integer.MAX_VALUE) {
                    int secondMin2 = Integer.MAX_VALUE;
                    int count = 0;
                    for(int num : nums){
                        if(num % 3 == 2){
                            if(num != min2){
                                secondMin2 = Math.min(secondMin2, num);
                            }
                        }
                    }
                    if(secondMin2 != Integer.MAX_VALUE){
                        return Math.min(1, 2);
                    } else {
                        return 1;
                    }

                } else {
                    return 1;
                }
            } else if (min2 != Integer.MAX_VALUE) {
                 int secondMin2 = Integer.MAX_VALUE;
                 int count = 0;
                    for(int num : nums){
                        if(num % 3 == 2){
                            if(num != min2){
                                secondMin2 = Math.min(secondMin2, num);
                            }
                        }
                    }
                   if(secondMin2 != Integer.MAX_VALUE){
                        return 2;
                    } else {
                        return -1;
                    }
            } else {
                return -1;
            }
        } else {
             if (min2 != Integer.MAX_VALUE) {
                if (min1 != Integer.MAX_VALUE) {
                    int secondMin1 = Integer.MAX_VALUE;
                    int count = 0;
                    for(int num : nums){
                        if(num % 3 == 1){
                            if(num != min1){
                                secondMin1 = Math.min(secondMin1, num);
                            }
                        }
                    }
                    if(secondMin1 != Integer.MAX_VALUE){
                        return Math.min(1, 2);
                    } else {
                        return 1;
                    }

                } else {
                    return 1;
                }

            } else if (min1 != Integer.MAX_VALUE) {
                 int secondMin1 = Integer.MAX_VALUE;
                    int count = 0;
                    for(int num : nums){
                        if(num % 3 == 1){
                            if(num != min1){
                                secondMin1 = Math.min(secondMin1, num);
                            }
                        }
                    }
                   if(secondMin1 != Integer.MAX_VALUE){
                        return 2;
                    } else {
                        return -1;
                    }
            } else {
                return -1;
            }
        }
    }
}