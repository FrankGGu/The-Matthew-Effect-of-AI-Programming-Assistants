func canCompleteTrainingPlan(required []int, training []int) bool {
    trainingDays := len(training)
    requiredDays := len(required)

    if trainingDays < requiredDays {
        return false
    }

    for i := 0; i <= trainingDays-requiredDays; i++ {
        valid := true
        for j := 0; j < requiredDays; j++ {
            if training[i+j] < required[j] {
                valid = false
                break
            }
        }
        if valid {
            return true
        }
    }
    return false
}